From: "Louis Jung" <lhsj81@gmail.com>
Subject: I2C error
Date: Mon, 1 May 2006 12:25:41 +1000
Message-ID: <cb6819fd0604301925x6b7ea289p11791fdb29ef4d5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I was wondering whether anyone using the scratchbox had issue with compilin=
g
a C code that includes <linux/i2c.h> header file.
I have a ADC connected to I2C peripheral on my Innovator OMAP5910 and I am
trying to obtain some data from it. I created a simple
code that utilizes the IOCTL commands that are available in the
<linux/i2c.h> and <linux/i2c-dev.h>. However, if I compile the code,
then I get all different sorts of syntax errors in the headers that are
included within the two headers listed above. The first few lines of
errors that I get are:

In file included from /usr/include/linux/sched.h:12,
                     from /usr/include/linux/module.h:10,
                     from /usr/include/linux/i2c.h:31,
                     from myi2c.c:12:
/usr/include/linux/jiffies.h:16: error: parse error before "jiffies_64"
/usr/include/linux/jiffies.h:20: error: parse error before "get_jiffies_64"
In file included from /usr/include/linux/cpumask.h:8,
                     from /usr/include/linux/sched.h:15,
                     from /usr/include/linux/module.h:10,
                     from /usr/linclude/linux/i2c.h:31,
                     from myi2c.c:12:
/usr/include/linux/bitmap.h: In function 'bitmap_empty':
/usr/include/linux/bitmap.h:15: error: 'BITS_PER_LONG' undeclared (first us=
e
in this function)
......

The code myi2c.c ( i reduced the code down to minimum level)

...
#include <linux/i2c.h>
#include <linux/i2c-dev.h>

int main()
{
     int s;
     int adapter_nr =3D 0; (I checked /sys/class/i2c-dev to find the number=
)
     if(( s =3D open(filename, O_RDWR)) < 0) {
            printf("Couldn't open the device\n");
            exit(0);
    }
   int addr =3D 0x90;
   if(ioctl(s, I2C_SLAVE, addr)<0) {
           printf("Couldn't access the slave device\n");
           exit(0);
   }
   return 0;
}

compiling was done within the scratchbox environment using
gcc -Wall -o test myi2c.c

I tried compiling the code without the <linux/i2c.h> and the only error tha=
t
I get is that I2C_SLAVE is not defined.
Thus, if I include it, I get all different kind of errors.

I never accessed i2c peripheral from an OS before and I would appreciate an=
y
kind of help I can get.

Regards,
Louis
