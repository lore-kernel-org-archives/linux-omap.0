From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes against v4.3-rc1
Date: Tue, 15 Sep 2015 09:48:28 -0700
Message-ID: <20150915164828.GB4215@atomide.com>
References: <20150915154650.GS10928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150915154650.GS10928@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150915 08:54]:
> 
> - Fix pbias regulator compatible values as a pending regulator
>   fix needs those for MMC1 to work properly

And when the pbias regulator fix hits mainline, I'll send
one more pull request to correct the reg entries for pbias
for the MMC hassles. Here's a summary FYI:

http://article.gmane.org/gmane.linux.kernel.mmc/33911

Regards,

Tony
