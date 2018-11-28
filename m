From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7: Move the ti, no-idle quirk on proper gmac
 node
Date: Wed, 28 Nov 2018 17:11:35 -0600
Message-ID: <1c2e5a69-f0c4-47c6-79d4-a11521b6ecda@ti.com>
References: <1543401907-14751-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1543401907-14751-1-git-send-email-t-kristo@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 11/28/18 4:45 AM, Tero Kristo wrote:
> Hwmod parses the DT hierarchically from root to search for matching
> ti,hwmod property. With the introduction of L4 data, we have two nodes
> with the ti,hwmod = "gmac" declaration, and the hwmod core only matches
> the first one found, which is the target-module one. This node incorrectly
> dropped the ti,no-idle flag, which causes number of problems, like ignoring
> errata i877, and also causing an intermittent boot failure on certain dra7
> boards.
> 
> Fix the issue by moving the ti,no-idle flag to the proper node.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> FYI: The problem is seen in linux-next.

Thank you.
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com> 

-- 
regards,
-grygorii
