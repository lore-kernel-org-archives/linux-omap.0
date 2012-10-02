From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] ARM: OMAP: hwmod: align the SmartReflex fck names
Date: Tue, 02 Oct 2012 15:08:00 -0700
Message-ID: <506B65C0.7070902@deeprootsystems.com>
References: <1348134503-28220-1-git-send-email-j-pihet@ti.com>
 <1348497352-6464-1-git-send-email-j-pihet@ti.com>
 <87626s8rys.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87626s8rys.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 10/02/2012 02:49 PM, Kevin Hilman wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Rename the smartreflex fck names for consistency and better readability;
>> rename the clock aliases for use by the SmartReflex driver, with the
>> "smartreflex.%d" format.
>
> hmm, do we even need the clkdev nodes anymore?  The driver isn't
> directly accessing the fclk at all, so it seems like these could be
> removed now.

Please ignore this comment, I see what you're doing in the other series 
now.  See my comments there.

Kevin
