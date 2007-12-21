From: "Azhar Mr." <shaik.azharuddin@yahoo.co.in>
Subject: netlink-socket program
Date: Fri, 21 Dec 2007 04:18:27 +0000 (GMT)
Message-ID: <250419.26500.qm@web7605.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

  I am working on OMAP5912 OSK.
   
  I want to have communication between kernel module and user space application. For communication I am using netlink sockets. I have successfully compiled user space application. But unable to compile kernel
module. :-(. It is giving error as 'Dereferencing pointer to incomplete type'

The psuedocode is as follows for kernel module 

#include <sys/socket.h>
#include <linux/netlink.h>

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/slab.h>
#include <linux/fs.h>
#include <linux/sched.h>
#include <asm/uaccess.h>
#include <linux/poll.h>
#include <linux/interrupt.h>
#include <linux/wait.h>
#include <linux/delay.h>
#include <linux/time.h>
#include <linux/vmalloc.h>
#include <asm/io.h>

#include <linux/init.h>
#include <linux/list.h>
#include <linux/platform_device.h>
#include <linux/timer.h>
#include <linux/err.h>
#include <linux/input.h>
#include <asm/arch/hardware.h>
#include <asm/arch/gpio.h>
#include <asm/arch/irqs.h>
#include <asm/arch/mux.h>
#include <asm/arch/board.h>

#define MAX_PAYLOAD 1024
/* Define any of the valid GPIO pins as LED_GPIO */
#define LED_GPIO 7

/* Defines the value written to the pin defined as
LED_GPIO */
#define LED_STATUS 1

MODULE_LICENSE("Dual BSD/GPL");

// Note: Debug is not implemented
static int debug = 0;

module_param(debug, int, 0);
MODULE_PARM_DESC(debug, "Debug information (default
0)");

static struct sock *nl_sk = NULL;

static void nl_data_ready (struct sock *sk, int len)
{
wake_up_interruptible(sk->sk_sleep);
}

static void netlink_test()
{
struct sk_buff *skb = NULL;
struct nlmsghdr *nlh = NULL;
int err;
u32 pid;

nl_sk = netlink_kernel_create(NETLINK_TEST,
nl_data_ready);
skb = skb_recv_datagram(nl_sk, 0, 0, &err);

nlh = (struct nlmsghdr *)skb->data;
printk(KERN_INFO "%s: received netlink message
payload: %s\n", __FUNCTION__, NLMSG_DATA(nlh));

pid = nlh->nlmsg_pid;
NETLINK_CB(skb).groups = 0;
NETLINK_CB(skb).pid = 0;
NETLINK_CB(skb).dst_pid = pid;
NETLINK_CB(skb).dst_groups = 0;
netlink_unicast(nl_sk, skb, pid, MSG_DONTWAIT);
sock_release(nl_sk->sk_socket);
}

static int __init init_module(void)
{
 /* requesting for LED_GPIO */
 if(omap_request_gpio(LED_GPIO)<0)
 {
 printk("[ERROR]: Failed in allocating the requested
GPIO Pin \n");
  return -1;
 }
 
 /* setting LED_GPIO as output pin */
 omap_set_gpio_direction(LED_GPIO,0);

 /* writing to LED_GPIO the value of LED_STATUS */
 omap_set_gpio_dataout(LED_GPIO,1);

 /* printing the value of LED_GPIO pin */
 printk("value of pin # %d =
%d\n",LED_GPIO,omap_get_gpio_datain(LED_GPIO));

 printk("\n [START] : netlink_test");
 netlink_test();
 printk("\n [END] : netlink_test");
 
 return 0;
}

static void __exit cleanup_module(void)
{
 omap_free_gpio(LED_GPIO); 
 printk("[SUCCESS]: LED_GLOW Module unregistered
successfull.\n");
}

After compiling the kernel module I am getting the
following errors



drivers/leds/leds-glow.c:1:24: sys/socket.h: No such
file or directory
drivers/leds/leds-glow.c: In function `nl_data_ready':
drivers/leds/leds-glow.c:53: error: dereferencing
pointer to incomplete type
drivers/leds/leds-glow.c: At top level:
drivers/leds/leds-glow.c:57: warning: function
declaration isn't a prototype
drivers/leds/leds-glow.c: In function `netlink_test':
drivers/leds/leds-glow.c:63: error: `NETLINK_TEST'
undeclared (first use in this function)
drivers/leds/leds-glow.c:63: error: (Each undeclared
identifier is reported only once
drivers/leds/leds-glow.c:63: error: for each function
it appears in.)
drivers/leds/leds-glow.c:63: warning: passing arg 2 of
`netlink_kernel_create' makes integer from pointer
without a cast
drivers/leds/leds-glow.c:63: error: too few arguments
to function `netlink_kernel_create'
drivers/leds/leds-glow.c:67: warning: char format,
void arg (arg 3)
drivers/leds/leds-glow.c:70: error: structure has no
member named `groups'
drivers/leds/leds-glow.c:72: error: structure has no
member named `dst_pid'
drivers/leds/leds-glow.c:73: error: structure has no
member named `dst_groups'
drivers/leds/leds-glow.c:75: error: dereferencing
pointer to incomplete type
drivers/leds/leds-glow.c: At top level:
drivers/leds/leds-glow.c:79: warning: static
declaration for `init_module' follows non-static
drivers/leds/leds-glow.c:104: warning: static
declaration for `cleanup_module' follows
non-staticdrivers/leds/leds-glow.c:79: warning:
`init_module' defined but not used
drivers/leds/leds-glow.c:104: warning:
`cleanup_module' defined but not used
make[2]: *** [drivers/leds/leds-glow.o] Error 1
make[1]: *** [drivers/leds] Error 2
make: *** [drivers] Error 2

Please Help.
  With Regards
Azharuddin


       
---------------------------------
 Unlimited freedom, unlimited storage. Get it now
