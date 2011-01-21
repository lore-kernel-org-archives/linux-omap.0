From: "Will Deacon" <will.deacon@arm.com>
Subject: RE: [PATCH v2 3/3] ARM: oprofile: Always allow backtraces
Date: Fri, 21 Jan 2011 11:27:36 -0000
Message-ID: <41488.2315592424$1295609547@news.gmane.org>
References: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
	<1295549840-17809-4-git-send-email-kauppi@papupata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1295549840-17809-4-git-send-email-kauppi@papupata.org>
Content-Language: en-gb
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Ari Kauppi' <kauppi@papupata.org>, Robert Richter <robert.richter@amd.com>
Cc: Matt Fleming <matt@console-pimps.org>, linux-omap@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Ari,

> Always allow backtrace when using oprofile on ARM, even if a PMU
> isn't present. Implemented by removing code and using stubs
> provided by <linux/oprofile.h>.
> 
> Restores functionality originally introduced in commit
> 1b7b56982fdcd9d85effd76f3928cf5d6eb26155 ("oprofile: Always allow
> backtraces on ARM") by Richard Purdie.
> 
> Signed-off-by: Ari Kauppi <kauppi@papupata.org>
> ---
>  arch/arm/oprofile/common.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)

[...]

Providing Robert is happy with the associated changes to
linux/oprofile.h then this patch looks good to me.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
