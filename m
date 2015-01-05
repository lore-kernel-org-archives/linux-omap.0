From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods
 without sysc
Date: Mon, 5 Jan 2015 22:19:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501052219240.28771@utopia.booyaka.com>
References: <1418917790-1791-1-git-send-email-rogerq@ti.com>
 <5492F84E.7020706@ti.com>
 <alpine.DEB.2.02.1501020654050.27058@utopia.booyaka.com>
 <54AA4CD4.40105@ti.com> <54AAEBCC.2030900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54AAEBCC.2030900@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Suman Anna <s-anna@ti.com>
Cc: nm@ti.com, Lokesh Vutla <lokeshvutla@ti.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, tony@atomide.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, 5 Jan 2015, Suman Anna wrote:

> That's right, the test was present even before 6423d6df1440, I merely
> made this a block.

Indeed, I misread the commit.  Sorry about ihat.


- Paul
