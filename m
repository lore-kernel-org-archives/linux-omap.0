From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: omap_hwmod: Fix up resource names when booted with
 devicetree
Date: Fri, 24 Aug 2012 15:38:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1208241536290.25436@utopia.booyaka.com>
References: <1345730049-12675-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-944834717-1345822611=:25436"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1345730049-12675-1-git-send-email-peter.ujfalusi@ti.com>
Content-ID: <alpine.DEB.2.00.1208241536590.25436@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-944834717-1345822611=:25436
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1208241536591.25436@utopia.booyaka.com>

Hello P=E9ter,

On Thu, 23 Aug 2012, Peter Ujfalusi wrote:

> When booted with some resource will have their name set to NULL. This can
> cause later kernel crash since this is not expected by the platform code.
>=20
> When we boot without DT the devices are created with platform_device_add(=
)
> which itself fixes up the missing resource names:
> if (r->name =3D=3D NULL)
> =09r->name =3D dev_name(&pdev->dev);
>=20
> The of core also fixes up the resource names when taking the information
> from DT data - in __of_address_to_resource():
> r->name =3D name ? name : dev->full_name;
>=20
> When we boot OMAP with devicetree: of will create the devices based on th=
e
> DT data so the resource names are guarantied to be not NULL. Since we hav=
e
> the 'ti,hwmod' tag, we remove the of created resources from the device an=
d
> re-create them based on hwmod data. If the hwmod data does not specify a
> name for a resource it will be NULL.
> This can cause kernel crash if the driver uses
> platform_get_resource_byname() to get any resource.

Do we need both this one and your '[PATCH] driver core: Check if r->name=20
is valid in platform_get_resource_byname()' ?  Or would that second patch=
=20
be enough?  Is the crash happening in the platform_get_resource_byname()=20
iterator?


- Paul
--843723315-944834717-1345822611=:25436
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--843723315-944834717-1345822611=:25436--
