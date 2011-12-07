From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] fixes for twl4030-irq in mainline
Date: Wed, 7 Dec 2011 20:34:47 +0200
Message-ID: <CAMP44s1Nhv-ggAh3-wPXVMaLkiNm9VUo4TnsaZm-yoSpttqaOQ@mail.gmail.com>
References: <20111126201334.16080.85045.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111126201334.16080.85045.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 26, 2011 at 10:17 PM, NeilBrown <neilb@suse.de> wrote:
> =C2=A0The recent tidying up of twl4030-irq seems to have left it brok=
en.
> At least it doesn't work for me on my gta04 (www.gta04.org). =C2=A0Th=
e
> first interrupt from the device freezes the whole system (by being
> constantly delivered)
>
> The following 4 patches make it work for me and addresses some other
> less critical issues like a typo in a comment :-)

I also hit the same issue on the N900. These patches fix the problem fo=
r me:

Tested-by: Felipe Contreras <felipe.contreras@gmail.com>

--=20
=46elipe Contreras
