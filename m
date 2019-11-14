From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: dts: am5729: beaglebone-ai: dra7 reqs in dts
Date: Thu, 14 Nov 2019 09:47:05 -0800
Message-ID: <20191114174705.GV5610@atomide.com>
References: <20191114170933.12623-1-c-robey@ti.com>
 <20191114170933.12623-2-c-robey@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191114170933.12623-2-c-robey@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Robey <c-robey@ti.com>
Cc: linux-omap@vger.kernel.org, Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "Andrew F . Davis" <afd@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tom Rini <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Caleb Robey <c-robey@ti.com> [191114 17:11]:

Hmm I think this one is still missing

From: Jason Kridner <jdk@ti.com>

If this too is Jason's patch? This happens if you apply a patch
manually instead of applying an email with git am.

You might be able to just change the From: line with
git commit --amend.

Regards,

Tony
