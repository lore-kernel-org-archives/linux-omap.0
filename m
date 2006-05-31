From: "Kanagesh R" <kanagesh@india.com>
Subject: Re: osk5912 boot failure with u-boot 1.1.4
Date: Wed, 31 May 2006 18:43:55 +0800
Message-ID: <20060531104355.2F49F244F6@ws5-3.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
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
To: Martin Margraf <m_margraf@web.de>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> hi,
>=20
> i compiled u-boot 1.1.4 with ELDK 4.0 and put it to my osk5912.
> but now my board does not boot anymore. how can i fix this?
>=20
> if i boot my board with u-boot 1.1.2 there is a conflict with the=20
> machine number.
> the u-boot machine number is 3 and the kernel machine number is 203??
> can i change the machine number in u-boot?
>=20
> regards
>=20
> martin

Hello,

To restore your OSK with a working u-boot bootloader, you would need CCS on=
 Windows and an emulator.  More details on restoring a board can be had fro=
m=20

http://omap.spectrumdigital.com/osk5912/factoryconfig/

I tried a u-boot-1.1.4 version compiled with ELDK 4.0 on my OMAP5912 OSK bu=
t it didn't boot aswell.  One of the reasons for this could be because of v=
ersions of the OSK boards, based on the processors they come with.  There i=
s a Rev. C board (the processor on these boards reads as an XOMAP) and ther=
e is a Rev. D board (the processor on them read OMAP or POMAP).  If your bo=
ard is a Rev. D one, then some changes specific to the POMAP/OMAP needs to =
be made in the u-boot sources.  A list of these changes can be found at the=
 Spectrum Digital site:

http://omap.spectrumdigital.com/osk5912/osk5912_faq.html

At the above site, check=20
- Section 10. Versioning=20
- Section E. Errata

With these changes in place, I was able to build a working u-boot-1.1.4 boo=
tloader for my Rev. D OSK board using the ELDK-3.1.1 toolchain.=20

Hope this helps,

Warm regards,
Kanagesh





--=20
India.com free e-mail - www.india.com.=20
Check out our value-added Premium features, such as an extra 20MB for mail =
storage, POP3, e-mail forwarding, and ads-free mailboxes!
