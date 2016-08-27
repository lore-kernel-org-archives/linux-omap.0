From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH] omapdrm: dss: drop unneeded of_node_put() on ref passed
 to of_get_next_parent()
Date: Sat, 27 Aug 2016 13:53:58 +0200
Message-ID: <CAALWOA8hrtrGZKpLZCdASPWK001p41YOmvFObF=FYSi2zCSROw@mail.gmail.com>
References: <20160826122321.4787-1-andrey_utkin@fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160826122321.4787-1-andrey_utkin@fastmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Utkin <andrey_utkin@fastmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Dave Airlie <airlied@gmail.com>, Peter Chen <peter.chen@nxp.com>, Rob Clark <robdclark@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Andrew Bradford <bradfa@gmail.com>, kernel@pyra-handheld.com, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, dri-devel@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sean Paul <seanpaul@chromium.org>
List-Id: linux-omap@vger.kernel.org

To clarify, this patch effectively reverts

commit 2ab9f5879162499e1c4e48613287e3f59e593c4f
gpu: drm: omapdrm: dss-of: add missing of_node_put after calling
of_parse_phandle

except it leaves behind unnecessary verbiage that this commit
introduced. And to be clear, that commit *should* indeed be reverted,
although preferably in its entirety obviously.

of_get_next_parent already drops a ref on its argument, so of_node_put
was never "missing" here.

Matthijs
