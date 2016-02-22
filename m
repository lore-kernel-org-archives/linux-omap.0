From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH] ARM: OMAP: DRA7: Make use of omap_revision information
 for soc_is* calls
Date: Mon, 22 Feb 2016 08:57:30 +0530
Message-ID: <56CA8022.6010206@ti.com>
References: <1455706123-26497-1-git-send-email-j-keerthy@ti.com>
 <20160219181514.GK21202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160219181514.GK21202@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Friday 19 February 2016 11:45 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [160217 02:49]:
>> Currently of_machine_is_compatible is used to detect the soc which
>> employs string comparison operations. We already have all the required
>> information in the omap_revision. Hence make use of the same like
>> the previous OMAPs and avoid costly string comparisons.
>
> Looks good to me thanks. Applying into omap-for-v4.6/soc.

Thanks Tony.

>
> Tony
>
