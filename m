From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next 6/6] Documentation: networking: cpsw: add MQPRIO
 & CBS offload examples
Date: Tue, 12 Jun 2018 23:36:39 +0300
Message-ID: <20180612203638.GC9473@khorivan>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
 <20180611133047.4818-7-ivan.khoronzhuk@linaro.org>
 <16c97ea6-9f28-1dd6-136a-2473423bf94a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16c97ea6-9f28-1dd6-136a-2473423bf94a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: davem@davemloft.net, corbet@lwn.net, akpm@linux-foundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, vinicius.gomes@intel.com, henrik@austad.us, jesus.sanchez-palencia@intel.com, ilias.apalodimas@linaro.org, p-varis@ti.com, spatton@ti.com, francois.ozog@linaro.org, yogeshs@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 12, 2018 at 02:55:18PM -0500, Grygorii Strashko wrote:
>
>
>On 06/11/2018 08:30 AM, Ivan Khoronzhuk wrote:
>>This document describes MQPRIO and CBS Qdisc offload configuration
>>for cpsw driver based on examples. It potentially can be used in
>>audio video bridging (AVB) and time sensitive networking (TSN).
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>---
>>  Documentation/networking/cpsw.txt | 540 ++++++++++++++++++++++++++++++
>>  1 file changed, 540 insertions(+)
>>  create mode 100644 Documentation/networking/cpsw.txt
>>
>>diff --git a/Documentation/networking/cpsw.txt b/Documentation/networking/cpsw.txt
>>new file mode 100644
>>index 000000000000..f5d58f502e52
>>--- /dev/null
>>+++ b/Documentation/networking/cpsw.txt
>
>Could you name it with "ti" prefix, pls?
>
>Like "ti-cpsw.txt" or "ti,cpsw.txt"
will name it ti-cpsw.txt in v2

>
>>@@ -0,0 +1,540 @@
>>+* Texas Instruments CPSW ethernet driver
>>+
>>+Multiqueue & CBS & MQPRIO
>>+=====================================================================
>>+=====================================================================
>[...]
>
>-- 
>regards,
>-grygorii

-- 
Regards,
Ivan Khoronzhuk
