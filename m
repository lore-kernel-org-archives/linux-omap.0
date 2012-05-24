From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP4+: hwmod: fix issue causing IPs not going back to
 Smart-Standby
Date: Thu, 24 May 2012 13:58:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205241358260.2572@utopia.booyaka.com>
References: <1334926326-26437-1-git-send-email-d-elaidi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1334926326-26437-1-git-send-email-d-elaidi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Djamil Elaidi <d-elaidi@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 20 Apr 2012, Djamil Elaidi wrote:

> If an IP is configured in Smart-Standby-Wakeup, when disabling wakeup feature the
> IP will not go back to Smart-Standby, but will remain in Smart-Standby-Wakeup.
> 
> Signed-off-by: Djamil Elaidi <d-elaidi@ti.com>

Thanks, queued for 3.5-rc fixes.


- Paul
