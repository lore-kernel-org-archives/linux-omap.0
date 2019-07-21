From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2+: Drop mmc platform data for am330x and
 am43xx
Date: Sat, 20 Jul 2019 21:42:49 -0500
Message-ID: <0af63198-5a68-2f0d-f14e-2b514580d2d5@lechnology.com>
References: <20190326181324.32140-1-tony@atomide.com>
 <20190326181324.32140-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190326181324.32140-2-tony@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 3/26/19 1:13 PM, Tony Lindgren wrote:
> We can now drop legacy platform data one interconnect target module at
> a time in favor of the device tree based data that has been added earlier.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

This breaks wifi on BeagleBone Blue (found via git bisect). In dmesg, I see:

     platform 47810000.mmc: Cannot lookup hwmod 'mmc3'

How can we fix it?
