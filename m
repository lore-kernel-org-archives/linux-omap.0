From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: Regression in next with "softirq: fix tasklet_kill() and its
 users"
Date: Thu, 22 Sep 2016 13:58:38 -0700
Message-ID: <a305129a-e2b4-9ba1-9e94-7998277da035@oracle.com>
References: <20160922205122.ezsxjint2l6lytyi@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160922205122.ezsxjint2l6lytyi@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 9/22/2016 1:51 PM, Tony Lindgren wrote:
> Hi Santosh,
>
> Looks like commit 1f5e9c3bc47f ("softirq: fix tasklet_kill() and
> its users") causes pandaboard es to not get any IP address on the
> smsc95xx USB Ethernet.
>
> Reverting the commits fixes the issue. Any ideas?
>
Yep. It was discussed today morning and Stephen was suppose to
revert that commit from next for now.

The tasklet core fix even though fixes the issue, there are many
bad users of tasklet which are using tasklet APIs without
doing any sort of tasklet initialization. So there is more
work to do before the tasklet core can be fixed.

Regards,
Santosh
