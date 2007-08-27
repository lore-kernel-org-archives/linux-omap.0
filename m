From: "Kanagesh R" <kanagesh@india.com>
Subject: Re: USB Function Driver code for OMAP 2430 SDP
Date: Tue, 28 Aug 2007 05:28:46 +0800
Message-ID: <20070827212846.801837B7AA@ws5-10.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
To: Amit Gupta <amitjobs05@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Amit,

> ----- Original Message -----
> From: "Amit Gupta" <amitjobs05@gmail.com>
> To: "Kanagesh R" <kanagesh@india.com>
> Subject: Re: USB Function Driver code for OMAP 2430 SDP
> Date: Tue, 28 Aug 2007 01:55:17 +0530
>=20
>=20
> Kanagesh
>=20
> Congrats, Its really nice that your USB function driver code is working.
>=20
> Well this has given me more hopes :)
>=20
> To tell you:-
>=20
> 1. I am using the
> linux.omap.com/pub/kernel/2430sdp/source/linux-2.6.14-omap2-v3.tgz
> source code for my kernel building. (The same has been used by you, so
> this does ot seems to be problem). You have not taken any patches
> above this code ?

Thats correct, I am using the same version of the kernel code, as downloade=
d from linux.omap.com.  I have NOT modified anything in the code.  I did re=
configure the kernel to enable the gadget drivers and disable the USB maste=
r (host) support.
=20
> 2. I am using the OMAP 2430 SDP 4.0, I am not sure about version 4.01.
> but there should not be much of difference in them.
>=20

I agree, there shouldn't be much of a difference between the two.

> 3. I am doing switch setting S6-6 , S6-7, S6-2 ON.
>=20
> So the only problem might be with the config file ? Can you send me
> your config file ( and tell me if you include the OTG components ?).
>=20

I have attached the config file that I have used here for your reference.  =
This is the same one that was mailed earlier by Khasim (thanks a lot, Khasi=
m!) on my request.

> Also how did you know, that Function Driver is working ? Dis you got
> OMAP_UDC interrupts(IRQ - 75)  and ISP1301 interrupts ? And how was
> the response on the Host (Desktop) side ? Did you also downloaded any
> driver on the host side for proper enumeration ?
>=20

Yes, I do see interrupts on the SDP board.=20=20

With the USB cable plugged into the host machine (Windows XP or Linux) on i=
nserting the mini-b connector to  connector J51, I can see that I receive i=
nterrupts for isp1301_omap, omap_udc (75) on the SDP board.

Windows will detect the board as an 'RNDIS' device and ask for a driver.  T=
he driver for Windows XP can be found in any Linux kernel source under fold=
er 'Documentation' named as linux.inf.  This is what I have used on the Win=
dows XP machine.

Once the driver installation is complete, I provide an IP address for inter=
face usb0 on the SDP board using the '/sbin/ifconfig' command as follows:

/sbin/ifconfig usb0 up 192.168.1.1  netmask 255.255.255.0

Windows will then assign an IP address to the new interface.=20=20

On the Linux host machine, ensure that module 'usbnet' (/lib/modules/`uname=
 -r`/kernel/drivers/usb/net/usbnet.ko) is registered with the kernel.  'dme=
sg' should be able to tell you if the Linux host recognized the SDP board a=
s a USB device.

You just have to issue an IP address to the usb0 interface using the /sbin/=
ifconfig command at both ends - the Linux host and the SDP board.  If that =
was successful, you would have an ethernet link between your linux host mac=
hine and the SDP board.=20=20

I recommend that you try to get it working with a Linux host first.=20

Hope this helps.

Regards,
Kanagesh

> And I hope you did not modified the code in any way. Kindly confirm
> the same by the earliest so that thingss work at my end also.
>=20
> Thanks & Regards
>=20
> Amit Gupta
>=20
>=20
>=20
> On 8/27/07, Kanagesh R <kanagesh@india.com> wrote:
> >
> >
> > Hello Everyone,
> >
> > I have finally been able to get USB gadget working on my OMAP2430=20
> > SDP board last week.  I guess it has been working well all the=20
> > time with the kernel that I am using - I was not setting the DIP=20
> > switch settings on the SDP board to the right configurations to=20
> > allow it to work on my board.
> >
> > I had mentioned the DIP switch settings to be a concern on one of=20
> > my mails and I received a reply saying that two DIP switches -=20
> > switches 6 (HSUSB_nFS) and 7 (HSVBUS_nFS) in S6 - had to be set=20
> > to the 'ON' position.  I later learnt that switch 2 (USB_nDB9) in=20
> > S6 needed to be set to the 'ON' position aswell.  With all these=20
> > switches set to the 'ON' position, plugging in the USB cable to=20
> > connector J51 (through ISP1301 transceiver) made things work like=20
> > a charm!
> >
> > I am now able to establish a TCP/IP link between the OMAP2430 SDP=20
> > board and a Windows XP system through ethernet over USB.  I have=20
> > done some basic testing on the link by making transfers to and=20
> > from both sides using FTP.
> >
> > In short, this is what I have:
> >
> > Board  : OMAP2430 SDP version V4.01
> > Kernel : linux.omap.com/pub/kernel/2430sdp/source/linux-2.6.14-omap2-v3=
.tgz
> > DIP Switch setting: Switches 2 (USB_nDB9), 6(HSUSB_nFS) and=20
> > 7()HSVBUS_nFS) in switch S6 set to position 'ON'
> > Toolchain: ARM toolchain with EABI support from www.codesourcery.com
> >
> > Hope this helps!  Thank you very much to everyone who had their=20
> > valuable inputs when I needed it.
> >
> > Regards,
> > Kanagesh
> >


=3D
Free Online Credit Report
Free credit report and score. View your credit history instantly.
http://a8-asy.a8ww.net/a8-ads/adftrclick?redirectid=3D4567f4a29447c577870f5=
d3fc5a6dacc


--=20
_______________________________________________
Search for products and services at:=20
http://search.mail.com
