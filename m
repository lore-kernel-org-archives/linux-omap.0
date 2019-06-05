From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 0/2] drm/panel-simple: Add panel parameters for ortustech-com37h3m05dtc/99dtc and sharp-lq070y3dg3b
Date: Wed, 5 Jun 2019 10:31:22 +0200
Message-ID: <E8EB9DF9-3684-4312-86E6-AA7BF38CF121@goldelico.com>
References: <cover.1559711222.git.hns@goldelico.com> <20190605082942.GC15169@ravnborg.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605082942.GC15169@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com, imirkin@alum.mit.edu, marek.belisko@gmail.com, letux-kernel@openphoenux.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Hi Sam,

> Am 05.06.2019 um 10:29 schrieb Sam Ravnborg <sam@ravnborg.org>:
>=20
> Hi Nikolaus.
>=20
> Thanks for the new panel patches.
> On Wed, Jun 05, 2019 at 07:07:01AM +0200, H. Nikolaus Schaller wrote:
>> V2:
>> * fix typo in 99dtc panel compatible string (reported by =
imirkin@alum.mit.edu)
>>=20
>> V1:
>>=20
>> Since v5.2-rc1 OMAP is no longer using a special display driver =
architecture
>> for DPI panels, but uses the general drm/panel/panel-simple.
>>=20
>> So we finally can add SoC independent panel definitions for two panel =
models
>> which we already had worked on quite a while ago (before device tree =
was
>> introduced):
>>=20
>> 	https://patchwork.kernel.org/patch/2851295/
>>=20
>>=20
>>=20
>> H. Nikolaus Schaller (2):
>>  drm/panel: simple: Add Sharp LQ070Y3DG3B panel support
>>  drm/panel: simple: Add Ortustech COM37H3M panel support
>=20
> All three panels are missing binding documentation.
> Please submit binding documentation, in separate patches, with
> proper "dt-bindings: xxx" subjects.
> See Documentation/device-tree/bindings/submitting...

Ah, ok. Yes, will add to v3 asap.

>=20
> Patches not applied due to the missing docs.
> But the patches itself looked good.
> You have specified bus_flags etc, and added the
> new entries in correct alphabetical order etc.
>=20
> 	Sam

BR and thanks,
Nikolaus
