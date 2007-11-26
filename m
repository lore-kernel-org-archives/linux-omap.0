From: "Krishna Prasad Herur" <kherur@nextwave.com>
Subject: RE: Peculiar Behaviour of the GPIO Program
Date: Mon, 26 Nov 2007 15:55:21 -0800
Message-ID: <E6CCDC65B8C522458685D8D1F145FEA801A34BA7@CA2-MSX-C01.nw.net>
References: <74079.72407.qm@web7604.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <74079.72407.qm@web7604.mail.in.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Azhar Mr." <shaik.azharuddin@yahoo.co.in>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The GPIO driver does not automatically do the required pin muxing for
you. It is possible that the pin you are looking at is muxed with other
signals. Look at the OMAP TRM, and set the Pin Mux register correctly.
-Prasad

-----Original Message-----
From: =
linux-omap-open-source-bounces+kherur=3Dnextwave.com@linux.omap.com
[mailto:linux-omap-open-source-bounces+kherur=3Dnextwave.com@linux.omap.c=
o
m] On Behalf Of Azhar Mr.
Sent: Thursday, November 22, 2007 10:35 PM
To: linux-omap-open-source@linux.omap.com
Subject: Peculiar Behaviour of the GPIO Program

Dear all,
  =20
  I am working on OMAP5912 OSK.
  =20
  I am trying to write a simple GPIO Program to write a value '1' to a
particular free GPIO Pin. For that I had written a program led_glow.c
given below.
  =20
  /* define any of the valid GPIO pins as LED_GPIO */
  #define LED_GPIO 18
  =20
  =20
  /* Defines the value written to the pin defined as LED_GPIO */
  =20
  #define LED_STATUS 1
  =20
  MODULE_LICENSE("Dual BSD/GPL");
  =20
  =20
  int init_module(void)
  {
        /* requesting for LED_GPIO */
        if(omap_request_gpio(LED_GPIO)<0)
        {
   printk("[ERROR]: Failed in allocating the requested GPIO Pin \n");
              return -1;
        }
       =20
        /* setting LED_GPIO as output pin */
  =20
       omap_set_gpio_direction(LED_GPIO,0);
  =20
        /* writing to LED_GPIO the value of LED_STATUS */
  =20
        omap_set_gpio_dataout(LED_GPIO,LED_STATUS);
  =20
        /* printing the value of LED_GPIO pin */
  =20
  printk("value of pin # %d =3D
%d\n",LED_GPIO,omap_get_gpio_datain(LED_GPIO));
  =20
        return 0;
  }
  =20
  void cleanup_module(void)
  {
        omap_free_gpio(LED_GPIO);    =20
  printk("[SUCCESS]: LED_GLOW Module unregistered successfull.\n");
  }
  =20
  =20
  I included our led_glow.c as a module in the Linux-2.6.22/drivers/leds
directory .
  =20
  Then using arm-linux-gcc compiler, I compiled the led_glow.c code to
obtain led_glow.ko
  =20
  Then using the insmod I inserted the module led_glow.ko in the
  OSK5912 Environment.
  =20
  I tested the module with various free GPIO-Pins of Expansion connector
'C'
  =20
  For some GPIO pins it is able to write the value '1' and for some pins
it is unable to write '1'
  =20
  Sh-3.00# value of pin #15 =3D 1
  Sh-3.00# value of pin #16 =3D 1
  Sh-3.00# value of pin #17=3D 0
  Sh-3.00# value of pin #20 =3D 0
  =20
  I tested all the free GPIO pins of EXPANSION CONEECTOR C, irrespective
of the printed value at the GPIO Pins at all the GPIO Pins I can observe
only '0' value in the C.R.O. I could not get any response in the C.R.O
  =20
  I don't understand this peculiar behavior of my GPIO-CODE.
  =20
  Please Help
  =20
  With Regards
  =20
  Azhar

      =20
---------------------------------
 Bring your gang together - do your thing.  Start your group.
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
