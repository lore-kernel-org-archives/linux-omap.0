From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
Date: Fri, 15 Jun 2012 12:36:13 +0530
Message-ID: <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
 <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
 <20120614154820.GG17140@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120614154820.GG17140@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, Aneesh V <aneesh@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 14, 2012 at 9:18 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 14, 2012 at 03:59:24PM +0530, Santosh Shilimkar wrote:
> > From: Aneesh V <aneesh@ti.com>
> >
> > Device tree support for the EMIF driver.
> >
> > Reviewed-by: Benoit Cousson <b-cousson@ti.com>
> > Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> > Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Aneesh V <aneesh@ti.com>
> > [santosh.shilimkar@ti.com: Rebased against 3.5-rc]
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Am I the memory maintainer now taking these patches?
>
I assumed that.
With your ack, $subject patch should go along with other 3 OMAP
platform patches because of dependency.

> > @@ -1267,7 +1534,13 @@ static int __init_or_module emif_probe(struct
> > platform_device *pdev)
> > =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 *res;
> > =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> >
> > - =A0 =A0 emif =3D get_device_details(pdev);
> > +#if defined(CONFIG_OF)
> > + =A0 =A0 if (pdev->dev.of_node)
> > + =A0 =A0 =A0 =A0 =A0 =A0 emif =3D of_get_device_details(pdev->dev.of_n=
ode,
> > &pdev->dev);
> > + =A0 =A0 else
> > +#endif
> > + =A0 =A0 =A0 =A0 =A0 =A0 emif =3D get_device_details(pdev);
> > +
>
> Can't you do this without the #ifdef?
>
Can be done. Just need to have empty of_get_device_details()
for the !CONFIG_OF build to avoid build break.

Will fix that.

Regards
santosh
