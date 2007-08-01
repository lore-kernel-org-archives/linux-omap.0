From: "Amit Gupta" <amitjobs05@gmail.com>
Subject: Fwd: FSUSB Port on OMAP2430 SDP
Date: Wed, 1 Aug 2007 10:48:50 +0530
Message-ID: <78d6ed630707312218w60198970rd8e98f1feb8261f0@mail.gmail.com>
References: <78d6ed630707301234k2b14adb9mec1aecfd50a5eb22@mail.gmail.com>
	<B62D67BD8EC3324C8A3DACEEA1A0D6C6021B9A5B@dlee12.ent.ti.com>
	<78d6ed630707311150x607380dbsa71cec7c51c61529@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <78d6ed630707311150x607380dbsa71cec7c51c61529@mail.gmail.com>
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
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello

Thanks for the prompt reply.

As per the reference manual, I saw the FSUSB port 0 being OTG port which has
connections with FS - host controller and FS- device controller. Also as you
mentioned the routing of signals beteween OTG and mini AB receptacle J51
happens through
ISP 1301(OTG transceiver). I have included :-

CONFIG_USB_OTG , CONFIG_USB_OHCI_HCD, CONFIG_USB_OMAP24XX_FS_PORT0 ,
CONFIG_ARCH_OMAP243X and CONFIG_ISP1301_OMAP

among the main ones. So i am trying to configure the port as FSUSB port as
host with these configurations.

Other Configurations I am using :-
1. I am using OMAP 2430 SDP v4.0
2. I have made switch setting S-6-6 and S-6-7 ON for using FSUSB port 0
3. I am connecting mini B cable to my mini AB port and connecting mass
storage device at the other end.


As of now my device is not getting powered ON( the mass storage poer LED is
not glowing which reqires 5 volts )  itself and its not registering any of
the interrupts. Kindly tell me the reason for the same


Also if possible, kindly let me know if I can configure any of the other
ports on OMAP 2430 SDP v4.0 as host ports.

Thanks & Regards

Aman



On 7/31/07, Kipisz, Steven <s-kipisz2@ti.com> wrote:
>
> Amit,
> I think that port is either host or client.  You have to choose either
> host or Gadget, and not OTG.
>
> Make sure you have the ISP1301 enabled in the I2C drivers.  Do not
> select the TWL4030 USB transceiver.
>
> Under USB, make sure you only have host selected (deselect Gadget).
> Also make sure you select OHCI and NOT the Inventra.
>
> Steve K.
>
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto: linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Amit
> Gupta
> Sent: Monday, July 30, 2007 2:34 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: FSUSB Port on OMAP2430 SDP
>
> Hello
>
> I am using OMAP 2430 SDP v4.0 and trying to configure the FS USB port
> 0(J51
> on the main board) as host. I am using kernel v2.6.14
>
>
>
> I am not getting any of the interrupts after connecting the cable/and
> device. And the device (mass storage device) is not getting configured.
>
>
>
> *        Does the port need to configure as OTG port and then make it as
> host? That's how it seems to me from the code.
>
>
>
> *        Do we need to make any changes in the files for making it to
> work?
> Also kindly send the config file for the same.
>
> Thanks & Regards
>
> Amit
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
