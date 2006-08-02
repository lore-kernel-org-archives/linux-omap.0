From: Arnold <abo_gwapo@yahoo.com>
Subject: Re: NETDEV WATCHDOG (additonal info)
Date: Tue, 1 Aug 2006 23:41:31 -0700 (PDT)
Message-ID: <20060802064131.52892.qmail@web55815.mail.re3.yahoo.com>
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

How I end up having a system hang and NETDEV WATCHDOG
error:

1.)omap_request_gpio(2);
2.)omap_set_gpio_direction(pin, DIRECTION_FOR_OUTPUT);
3.)printk(" Writing at pin = %d\n",pin);
4.)omap_set_gpio_dataout(2,1);
5.)printk("Value of pin =
%d\n",omap_get_gpio_datain(2));
6.)omap_free_gpio(2);

After this I'm encountering NETDEV WATCHDOG error.

--- Arnold <abo_gwapo@yahoo.com> wrote:

> > P.S.: Ethernet interrupt is connected to GPIO 0 of
> > bank 0. 
> > So the NETDEV WATCHDOG stuff may come either
> because
> > you 
> > accidently touched anything what is necessary for
> > proper 
> > ethernet interrupt. Or the GPIO interrupt you are
> > dealing 
> > with is coming so often that there isn't enough
> time
> > for 
> > ethernet irq. 
 
 This problem occurs only if I stop the program.
 Which
 calls the omap_free_gpio. Does freeing the gpio pin
 be
 the cause of the problem?


 
> Thanks,
> OJ
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam
> protection around 
> http://mail.yahoo.com 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
