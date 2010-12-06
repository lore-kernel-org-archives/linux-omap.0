From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: overwrite DSP error codes
Date: Mon, 6 Dec 2010 02:53:39 -0600
Message-ID: <AANLkTikxrXXW-M7EJ1aWiuyHg1un4+cTo8=Cb4DqiYk+@mail.gmail.com>
References: <1288830684-7828-1-git-send-email-rene.sapiens@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1288830684-7828-1-git-send-email-rene.sapiens@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Sapiens <rene.sapiens@ti.com>
Cc: greg@kroah.com, gregkh@suse.de, nm@ti.com, felipe.contreras@gmail.com, ernesto@ti.com, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 3, 2010 at 7:31 PM, Rene Sapiens <rene.sapiens@ti.com> wrot=
e:
> When calling the DSP's remote functions, the DSP returns error
> codes different from the ones managed by the kernel, the
> function's return value is shared with the MPU using a shared
> structure. This patch overwrites those error codes by kernel
> specifics and deletes unnecessary code.
>
> Signed-off-by: Rene Sapiens <rene.sapiens@ti.com>
> ---
> =A0drivers/staging/tidspbridge/rmgr/disp.c | =A0 44 +++++------------=
-------------
> =A01 files changed, 8 insertions(+), 36 deletions(-)

Pushed to dspbridge.

Regards,

Omar
