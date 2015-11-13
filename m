From: Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: designware: bail out if host_init failed
Date: Fri, 13 Nov 2015 18:49:08 +0900
Message-ID: <CAPOBaE5AwxQz6pscN3HfMuZjSFU61VLrkmO7DG-r5+czLFkO8w@mail.gmail.com>
References: <1447336125-5010-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1827096267512022244=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1447336125-5010-1-git-send-email-jszhang@marvell.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: "k.kozlowski@samsung.com" <k.kozlowski@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "pratyush.anand@gmail.com" <pratyush.anand@gmail.com>, "Richard.Zhu@freescale.com" <Richard.Zhu@freescale.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kishon@ti.com" <kishon@ti.com>, "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>, "kgene@kernel.org" <kgene@kernel.org>, "m-karicheri2@ti.com" <m-karicheri2@ti.com>, Han Jingoo <jingoohan1@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, l.stac
List-Id: linux-omap@vger.kernel.org

--===============1827096267512022244==
Content-Type: multipart/alternative; boundary=001a113fe6c290e147052468f8ff

--001a113fe6c290e147052468f8ff
Content-Type: text/plain; charset=UTF-8

2015. 11. 12. Thusday, Jisheng Zhang<jszhang@marvell.com> wrote:

> There's no reason to continue the initialization such as configure
> register, scan root bus etc. if customized host_init() failed. This
> patch tries to check the host_init result, bail out if failed.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com <javascript:;>>


Acked-by: Jingoo Han <jingoohan1@gmail.com>

---
>  drivers/pci/host/pci-dra7xx.c      |  4 +++-
>  drivers/pci/host/pci-exynos.c      |  4 +++-
>  drivers/pci/host/pci-imx6.c        |  4 +++-
>  drivers/pci/host/pci-keystone.c    |  4 +++-
>  drivers/pci/host/pci-layerscape.c  | 25 ++++++++++++++++---------
>  drivers/pci/host/pcie-designware.c |  7 +++++--
>  drivers/pci/host/pcie-designware.h |  2 +-
>  drivers/pci/host/pcie-spear13xx.c  |  4 +++-
>  8 files changed, 37 insertions(+), 17 deletions(-)
>

--001a113fe6c290e147052468f8ff
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2015. 11. 12.=C2=A0Thusday, Jisheng Zhang&lt;<a href=3D"mailto:jszhang@marv=
ell.com">jszhang@marvell.com</a>&gt; wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">There&#39;s no reason to continue the initialization such as configure<b=
r>
register, scan root bus etc. if customized host_init() failed. This<br>
patch tries to check the host_init result, bail out if failed.<br>
<br>
Signed-off-by: Jisheng Zhang &lt;<a href=3D"javascript:;" onclick=3D"_e(eve=
nt, &#39;cvml&#39;, &#39;jszhang@marvell.com&#39;)">jszhang@marvell.com</a>=
&gt;</blockquote><div><br></div><div>Acked-by: Jingoo Han &lt;<a href=3D"ma=
ilto:jingoohan1@gmail.com">jingoohan1@gmail.com</a>&gt;</div><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
---<br>
=C2=A0drivers/pci/host/pci-dra7xx.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A0drivers/pci/host/pci-exynos.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A0drivers/pci/host/pci-imx6.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +++-=
<br>
=C2=A0drivers/pci/host/pci-keystone.c=C2=A0 =C2=A0 |=C2=A0 4 +++-<br>
=C2=A0drivers/pci/host/pci-layerscape.c=C2=A0 | 25 ++++++++++++++++--------=
-<br>
=C2=A0drivers/pci/host/pcie-designware.c |=C2=A0 7 +++++--<br>
=C2=A0drivers/pci/host/pcie-designware.h |=C2=A0 2 +-<br>
=C2=A0drivers/pci/host/pcie-spear13xx.c=C2=A0 |=C2=A0 4 +++-<br>
=C2=A08 files changed, 37 insertions(+), 17 deletions(-)<br>
</blockquote>

--001a113fe6c290e147052468f8ff--

--===============1827096267512022244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============1827096267512022244==--
