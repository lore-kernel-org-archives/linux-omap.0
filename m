From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/8] OMAP2+: PM: idle clkdms only if already in idle
Date: Mon, 27 Jun 2011 00:34:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106270012410.460@utopia.booyaka.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
	<1307616853-28395-2-git-send-email-rnayak@ti.com>
	<1307616853-28395-3-git-send-email-rnayak@ti.com>
	<1307616853-28395-4-git-send-email-rnayak@ti.com>
	<1307616853-28395-5-git-send-email-rnayak@ti.com>
	<20110610001556.GA9159@google.com> <4DF1FE6A.3010202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4DF1FE6A.3010202@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>, Todd Poynor <toddpoynor@google.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Rajendra, Todd,

On Fri, 10 Jun 2011, Rajendra Nayak wrote:

> Paul/Benoit any thoughts on if a per-clkdm lock seems reasonable?

Sounds okay to me.

The experimental patch that you sent didn't add the locking to the *wkdep, 
*sleepdep functions; I guess we'd better add it there at the same time, 
since some of the register access there does a read-modify-write.

It should be possible to get rid of the atomic_t usage in the clockdomain 
code as part of the same series.

Todd, thanks for pointing this out.


- Paul
