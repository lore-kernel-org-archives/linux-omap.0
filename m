From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [RFC] Device Tree Overlays Proposal (Was Re: capebus moving omap_devices to mach-omap2)
Date: Wed, 7 Nov 2012 09:13:36 +0100
Message-ID: <5ED17D42-07B8-4D4F-B54F-82B4CC60584C@antoniou-consulting.com>
References: <CACxGe6vu8ek7-K-yDDMXyg9x-oKiFt_cSz+Pz-yZf5U5vwe=0g@mail.gmail.com> <02FF5400-9F97-4B8A-AEF0-267B01C8099F@antoniou-consulting.com> <CACxGe6vDzmPWsOZ53HTwkYmDEivg9TpnRrvudY2FK95V06O24w@mail.gmail.com> <A5170602-2AE7-4EC4-BE0F-0DF015A287D7@antoniou-consulting.com> <CACxGe6sJXubOSGGg5AmDK6DQMjv60H44nax9wUnnCGsqXGbfxw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACxGe6sJXubOSGGg5AmDK6DQMjv60H44nax9wUnnCGsqXGbfxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <robherring2@gmail.com>, Deepak Saxena <dsaxena@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Scott Wood <scottwood@freescale.com>, Tony Lindgren <tony@atomide.com>, Russ Dill <Russ.Dill@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, devicetree-discuss@lists.ozlabs.org
List-Id: linux-omap@vger.kernel.org

Hi Grant

On Nov 6, 2012, at 9:45 PM, Grant Likely wrote:

> On Tue, Nov 6, 2012 at 7:34 PM, Pantelis Antoniou
> <panto@antoniou-consulting.com> wrote:

[ snip ]
> 
> g.

Since we've started talking about longer term goals, and the versioning
provision seems to stand, I hope we address how much the fragment versioning
thing is similar to the way board revisions progress.

If a versioning syntax is available then one could create a single DT 
file for a bunch of 'almost' similar board and board revisions.

Using a single DTB in the same manner you have a single uImage would
make some people quite happy, since you won't have to do any bootloader
magic to make sure you pass the correct DTB for the specific revision.

Regards

-- Pantelis
