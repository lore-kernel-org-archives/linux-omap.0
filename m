From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/5] arm: omap2: skip device build from platform code
 for dt.
Date: Mon, 28 Apr 2014 18:28:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1404281827410.14616@utopia.booyaka.com>
References: <1397651532-31456-1-git-send-email-sourav.poddar@ti.com>
 <1397651532-31456-4-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397651532-31456-4-git-send-email-sourav.poddar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, Sourav Poddar <sourav.poddar@ti.com>
Cc: wsa@the-dreams.de, michael.opdenacker@free-electrons.com, balbi@ti.com, bcousson@baylibre.com, zbr@ioremap.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 16 Apr 2014, Sourav Poddar wrote:

> For SOCs with dt enabled, device should be build through device tree.
> Prevent device build call from platform code, if device tree is
> enabled.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>

Isn't OMAP2+ only supporting DT device enumeration now?


- Paul
