From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP OneNAND: add missing __devexit_p wrappers
Date: Wed, 29 Apr 2009 10:55:51 -0700
Message-ID: <200904291055.51333.david-b@pacbell.net>
References: <7948530904290459q36d9c3fcq2db0dedcf88549d2@mail.gmail.com>
	<49F852EB.1080701@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <49F852EB.1080701@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Mika Korhonen <mika.j.korhonen@gmail.com>, linux-mtd Mailing List <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 29 April 2009, Adrian Hunter wrote:
> +       .shutdown       = __devexit_p(omap2_onenand_shutdown),

That looks wrong.  Shutdown functions shouldn't get discarded
like exit functions.  I'd think the fix for that would be taking
away any __devexit annotation on the shutdown function.


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
