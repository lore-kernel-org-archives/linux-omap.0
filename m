From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 13/15] ARM: AM33XX: Add aes0 crypto clock data
Date: Sun, 23 Dec 2012 16:47:36 +0100
Message-ID: <87licou5wn.fsf@dell.be.48ers.dk>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <1356107295-11121-14-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1356107295-11121-14-git-send-email-mgreer@animalcreek.com> (Mark
 A. Greer's message of "Fri, 21 Dec 2012 09:28:13 -0700")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

>>>>> "Mark" == Mark A Greer <mgreer@animalcreek.com> writes:

 Mark> From: "Mark A. Greer" <mgreer@animalcreek.com>
 Mark> Add clock data for for the SHA0 crypto module

s/SHA/AES/

Reviewed-by: Peter Korsgaard <jacmet@sunsite.dk>
 
 Mark> +static struct clk aes0_fck;
 Mark> +DEFINE_STRUCT_CLK_HW_OMAP(aes0_fck, NULL);
 Mark> +DEFINE_STRUCT_CLK(aes0_fck, dpll_core_ck_parents, clk_ops_null);

-- 
Bye, Peter Korsgaard
