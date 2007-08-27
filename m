From: "Kanagesh R" <kanagesh@india.com>
Subject: Re: USB Function Driver code for OMAP 2430 SDP
Date: Mon, 27 Aug 2007 22:28:01 +0800
Message-ID: <20070827142801.F1C9BCA0A4@ws5-11.us4.outblaze.com>
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
To: Amit Gupta <amit_jobs05@inbox.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


> ----- Original Message -----
> From: "Amit Gupta" <amit_jobs05@inbox.com>
> To: "Linux OMAP" <linux-omap-open-source@linux.omap.com>
> Subject: USB Function Driver code for OMAP 2430 SDP
> Date: Sat, 25 Aug 2007 02:28:38 +0530
>=20
>=20
> This is in continuation of the previous mail as below
>=20
> Are there any patches for the FSUSB function controller on OMAP2430
> SDPv4.0 since the code available in the public folder does not seem to
> work.
>=20

Hello Everyone,

I have finally been able to get USB gadget working on my OMAP2430 SDP board=
 last week.  I guess it has been working well all the time with the kernel =
that I am using - I was not setting the DIP switch settings on the SDP boar=
d to the right configurations to allow it to work on my board.

I had mentioned the DIP switch settings to be a concern on one of my mails =
and I received a reply saying that two DIP switches - switches 6 (HSUSB_nFS=
) and 7 (HSVBUS_nFS) in S6 - had to be set to the 'ON' position.  I later l=
earnt that switch 2 (USB_nDB9) in S6 needed to be set to the 'ON' position =
aswell.  With all these switches set to the 'ON' position, plugging in the =
USB cable to connector J51 (through ISP1301 transceiver) made things work l=
ike a charm!=20=20

I am now able to establish a TCP/IP link between the OMAP2430 SDP board and=
 a Windows XP system through ethernet over USB.  I have done some basic tes=
ting on the link by making transfers to and from both sides using FTP.=20=
=20

In short, this is what I have:

Board  : OMAP2430 SDP version V4.01
Kernel : linux.omap.com/pub/kernel/2430sdp/source/linux-2.6.14-omap2-v3.tgz
DIP Switch setting: Switches 2 (USB_nDB9), 6(HSUSB_nFS) and 7()HSVBUS_nFS) =
in switch S6 set to position 'ON'
Toolchain: ARM toolchain with EABI support from www.codesourcery.com

Hope this helps!  Thank you very much to everyone who had their valuable in=
puts when I needed it.

Regards,
Kanagesh



=3D
$3,500 - $7,000 Per Week
Must Be Ready To Start Immediately Great pay! Start Today.
http://a8-asy.a8ww.net/a8-ads/adftrclick?redirectid=3D9a9ddf1ba5d75a756383e=
82bf64670d8


--=20
_______________________________________________
Search for products and services at:=20
http://search.mail.com
