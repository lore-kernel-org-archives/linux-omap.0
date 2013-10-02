From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH] ARM: dts: AM33XX: add ethernet alias's for am33xx
Date: Wed, 2 Oct 2013 18:39:42 -0500
Message-ID: <524CAEBE.5010305@ti.com>
References: <1380736713-24678-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380736713-24678-1-git-send-email-dmurphy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dan Murphy <dmurphy@ti.com>, bcousson@baylibre.com
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 02 October 2013 12:58 PM, Dan Murphy wrote:
> Set the alias for ethernet0 and ethernet1 so that uBoot
> can set the MAC address appropriately.
>
> Currently uBoot cannot find the alias and there for does not set the
> MAC address.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Tested this with beagle bone black.

Tested-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N
