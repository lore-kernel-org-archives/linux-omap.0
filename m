From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: DT node Timer iteration fix
Date: Mon, 21 Jan 2013 10:37:07 -0800
Message-ID: <20130121183706.GJ22517@atomide.com>
References: <1357651902-21966-1-git-send-email-panto@antoniou-consulting.com>
 <50EDEB64.4060800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50EDEB64.4060800@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, Stephen Warren <swarren@wwwdotorg.org>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Joel A Fernandes <agnel.joel@gmail.com>, Rob Clark <robdclark@gmail.com>, Jason Kridner <jkridner@beagleboard.org>, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Jon Hunter <jon-hunter@ti.com> [130109 14:15]:
> Hi Pantelis,
> 
> On 01/08/2013 07:31 AM, Pantelis Antoniou wrote:
> > The iterator correctly handles of_node_put() calls.
> > Remove it before continue'ing the loop.
> > Without this patch you get:
> 
> Thanks for the fix!
> 
> May be worth mentioning that this will only be seen with
> "CONFIG_OF_DYNAMIC" (and explains why I did not catch this one!).

Thanks I'll update the description and apply into omap-for-v3.8-rc4/fixes.

Regards,

Tony
