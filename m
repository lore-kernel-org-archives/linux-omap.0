From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 7/8] arm: omap: clockdomain: add support for preventing
 domain transitions
Date: Wed, 15 Feb 2012 11:35:03 -0800
Message-ID: <87vcn799g8.fsf@ti.com>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
 <1329320274-481-8-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1329320274-481-8-git-send-email-t-kristo@ti.com> (Tero Kristo's
 message of "Wed, 15 Feb 2012 17:37:53 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> Some clockdomains can't support manual domain transitions triggered by
> clock framework, and must be prevented from doing so. Added clkdm flag
> CLKDM_NO_MANUAL_TRANS for doing this.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>

Dumb Q: what's the difference between this new flag and CLKDM_CAN_SWSUP?

Kevin
