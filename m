From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v3 0/4] ARM: OMAP4+: PM: Consolidate code for re-use on
 OMAP5
Date: Fri, 05 Apr 2013 16:42:41 -0700
Message-ID: <87mwtck0i6.fsf@linaro.org>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Fri, 5 Apr 2013 18:28:59 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> As discussed on list, I split the v2 [1] series into cleanup and OMAP5 support.

Thanks.

> This series contains the clean-up patches. I have rebased on top of Tony's
> pull request and your 3.10/* branches. Series is tested on OMAP4430 SDP
> with CPUIDLE and suspend. OMAP5 PM support I will post later since it has
> a dependency with OMAP5 data files which are not pulled in yet.

I've added 4/4 to my cpuidle branch and added 1,3/4 to my
for_3.10/cleanup/pm branch (now based on Tony's cleanup-v2 branch for
dependencies.)   Patch 2/4 needs a respin without the rename as per
Tony's comments.

Thanks,

Kevin
