From: Tom Rini <trini@ti.com>
Subject: Re: [RFC] Kbuild support for ARM FIT images
Date: Thu, 21 Feb 2013 08:20:56 -0500
Message-ID: <51261F38.2030902@ti.com>
References: <CAD=GYpbF_3uRzhUnV=MwDiy-ekvZKJztJbkhNM0u_pvG-UCw4w@mail.gmail.com> <20130221103705.GB17852@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20130221103705.GB17852@n2100.arm.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Joel A Fernandes <agnel.joel@gmail.com>, u-boot@lists.denx.de, Linux OMAP List <linux-omap@vger.kernel.org>, linux-kbuild@vger.kernel.org, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, "Fernandes, Joel A" <joelagnel@ti.com>, Grant Likely <glikely@secretlab.ca>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/21/2013 05:37 AM, Russell King - ARM Linux wrote:
> On Wed, Feb 20, 2013 at 07:37:10PM -0600, Joel A Fernandes wrote:
>> Hello, I've been spinning some work-in-progress patches for FIT
>> build support in the kernel. With the move to multiplatform
>> support on OMAP, I feel it is a good time to add  FIT support,
>> also looking at the proliferating number of dtbs, as it is a nice
>> way
> 
> I'm not looking to add yet another crappy uboot image format to the
> kernel just for the hell of uboot.

Note that FIT images are relatively old (docs date back to March
2008).  This is more of another effort to try and update what the
kernel uses.

> And don't think that the dtbs in the kernel are going to stay
> there.  The longer term plan is for them to end up in an external
> git tree, entirely separate from the kernel source.  So anything
> that ties them with the kernel build process will ultimately have
> to be removed again.

Well, once the device trees move to some external location, this
script could also easily move out with it.  And I'd hope there'd be
interest out in the rest of the world for a single file boots on
multiple platforms image format.  If the ability to do this was
actually well known, it might even stop people from re-inventing the
wheel for fun (re-inventing due to design problems with the previous
wheel is acceptable).

We're just about to make a lot of folks lives harder (whatever the
userbase is for omap2plus_defconfig).  How much time do we want to
spend offering up alternatives?

- -- 
Tom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRJh84AAoJENk4IS6UOR1W9BEP/3rxNUz9dNZ3PwfVBuXT6LiX
P6ANVDFg9uZTWTaoLgcTjXkmvexjpaeZz+5T0TOErDf/YoaOVqjfhVlZE82VE010
t7CC23cTGCOo7q/ofJalzUzhdZE2/DLsGXNdz4wi6f8N0v46DNdAuolUqgyYXjvg
3rKK7G3ZzWUrmhkILfsZ/8XvbQ+rUDlMDajUnr0RnarsxWbM6KkVPRbCzUrEfsZA
a4AKdg5msl2XxtgNlcOwvb4LCZXCmdRdulkGzf45AhyUpNGkgFYrCu5mlFvjYy9U
JGCw/2V9IqXqsN0hoBDxgRHvnN5o+EJasPZPxY2MMSRAr2fkhGPMicYW0jvo/t9G
DzNfQ2qZiHHY5SzuBzLh/ejRdviGm+SRrQTI2MSKEMixvUgsCL43UCBaMn09fv5o
kRjNLDvi0WeQ/T9PPF3xcbMQRlATW5VmBt8ZJ/OKmptjRAay3Eq44a2J1Bb89KGV
iuO7hxt1Yuo/Wc/6gghcJLDxn5EuE5oES/WLhmzEQE6c9u2xM5Ygmf2utiy4JZTo
Y9iilnP7mQ51TbV7cXtwLvLaR6rJHW3XIHinDHQVK26fACtAHRUoNzRI86HQnNQx
tnuDJPQcHUEWkG6aq9ikvxWx1j692lKpmPlVXZ7QoYWCdYdAVtpn8OP7iWih42XW
9+Gkuwfc2vaZfvC1LkGu
=iUUO
-----END PGP SIGNATURE-----
