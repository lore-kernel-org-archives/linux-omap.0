From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH] omapdrm: dss: drop unneeded of_node_put() on ref passed
 to of_get_next_parent()
Date: Sat, 27 Aug 2016 14:06:40 +0200
Message-ID: <CAALWOA-HbcmCLLdZV2U4EevKK+ujjQhq8MNfSk6K3y=EskjQpg@mail.gmail.com>
References: <20160826122321.4787-1-andrey_utkin@fastmail.com> <CAALWOA8hrtrGZKpLZCdASPWK001p41YOmvFObF=FYSi2zCSROw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAALWOA8hrtrGZKpLZCdASPWK001p41YOmvFObF=FYSi2zCSROw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Sean Paul <seanpaul@chromium.org>, Peter Chen <peter.chen@nxp.com>, Andrey Utkin <andrey_utkin@fastmail.com>
Cc: David Airlie <airlied@linux.ie>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Dave Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Andrew Bradford <bradfa@gmail.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, dri-devel@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> [    8.842806] OF: ERROR: Bad of_node_put() on /encoder/ports/port@1/endpoint
> [    8.843014] [<bf889433>] (omapdss_of_find_source_for_first_ep [omapdss])

I can confirm that reverting 2ab9f5879162 fixes this regression,
tested on omap5-uevm.

Matthijs
