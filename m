From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: Remove unused legacy code for device
 init
Date: Thu, 8 Jun 2017 04:10:40 -0700
Message-ID: <20170608111040.GL3730@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
 <20170531225139.30723-5-tony@atomide.com>
 <20170607222711.6kdhuvkymiseootn@earth>
 <20170608082825.GG3730@atomide.com>
 <20170608094712.GI3730@atomide.com>
 <20170608105553.dq7rhfwhvz3wwa3e@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170608105553.dq7rhfwhvz3wwa3e@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170608 03:59]:
> On Thu, Jun 08, 2017 at 02:47:12AM -0700, Tony Lindgren wrote:
> > Here's this one updated.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Thanks for looking.

> Defines for L3_MODULES_MAX_LEN + L3_MODULES and most of the includes
> could be dropped now.

Yeah I bet we have tons of unused defines now. I think
I used to have some shell script to grep for those
somewhere.

Regards,

Tony
