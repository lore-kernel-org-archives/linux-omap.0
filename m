From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: fix _idle() hwmod state sanity check
 sequence
Date: Sun, 10 Apr 2016 23:02:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1604102302080.11457@utopia.booyaka.com>
References: <1459812638-38789-1-git-send-email-s-anna@ti.com>
 <alpine.DEB.2.02.1604101840270.11457@utopia.booyaka.com>
 <570AC1EA.3030501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <570AC1EA.3030501@ti.com>
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
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Suman

On Sun, 10 Apr 2016, Suman Anna wrote:

> >> There are couple of pr_debug statements that only print once the code
> >> flow passes through certain conditions. Not sure if you wanted them
> >> to be printed first thing when entering the functions or only if the
> >> function is really doing something. But it is still not consistent
> >> between _enable(), _idle() and _shutdown().
> > 
> > Yeah those need to be cleaned up.  Seems like the best thing to do 
> > is to move them all to the beginning of their respective functions.
> 
> You want that fixed in this patch or a separate patch?

A separate one would be great.  No rush



- Paul
