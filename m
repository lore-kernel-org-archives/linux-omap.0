From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] ARM: OMAP2: DRA7: Modify optimize string
 comparisons in soc_is calls
Date: Fri, 16 Oct 2015 12:09:48 -0700
Message-ID: <20151016190948.GB24370@atomide.com>
References: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
 <1444885808-6306-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1444885808-6306-2-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [151014 22:14]:
> Currently everytime soc_is calls are made, firstly device tree nodes
> are parsed and then string comparisons are made to determine the
> soc version. Optimizing it to be done one time and store the result.
> Use the stored value in all the subsequent checks for soc_is calls.

Let's just get rid of the of_machine_is_compatible() checks here.

When dra7xxx_check_revision we already know it's dra7, no point for
any of the string parsing with of_machine_is_compatible(). We just
risk things going wrong.

And we already have omap_revision that gets populated based on the
hawkeye register, so let's use that instead. Can you please update
this patch just to use is_dra7xx() macros like the other use?

Regards,

Tony
