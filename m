From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] staging: tidspbridge: remove code referred by OPT_ZERO_COPY_LOADER
Date: Fri, 24 Dec 2010 01:43:28 -0600
Message-ID: <AANLkTi=yGdxYnNqDCQ0aak-gNmagOd2GNqGHQ+FoVhTf@mail.gmail.com>
References: <1292880188-5860-1-git-send-email-ernesto@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1292880188-5860-1-git-send-email-ernesto@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ernesto Ramos <ernesto@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ohad@wizery.com, felipe.contreras@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Dec 20, 2010 at 3:23 PM, Ernesto Ramos <ernesto@ti.com> wrote:
> Remove code referred by OPT_ZERO_COPY_LOADER since it is
> not used.
>
> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
> ---
> =A0drivers/staging/tidspbridge/dynload/cload.c | =A0 60 +++++++++----=
--------------
> =A01 files changed, 20 insertions(+), 40 deletions(-)

Pushed to dspbridge.

Regards,

Omar
