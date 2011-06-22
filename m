From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 2/8] remoteproc: add omap implementation
Date: Wed, 22 Jun 2011 13:50:28 +0300
Message-ID: <BANLkTin6eFqQLb-Wkq=Q7rbm7GCjKtz8zg@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-3-git-send-email-ohad@wizery.com>
	<BANLkTimAf9EqSX-yHh_0RPaeewndOyNUYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTimAf9EqSX-yHh_0RPaeewndOyNUYA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Newton <will.newton@gmail.com>
Cc: davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Arnd Bergmann <arnd@arndb.de>, Brian Swetland <swetland@google.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 22, 2011 at 1:05 PM, Will Newton <will.newton@gmail.com> wrote:
> On Tue, Jun 21, 2011 at 8:18 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>
>> +/* bootaddr isn't needed for the dual M3's */
>> +static inline int omap_rproc_start(struct rproc *rproc, u64 bootaddr)
>
>> +static inline int omap_rproc_stop(struct rproc *rproc)
>
> These two functions don't need to be inline as far as I can see.

They definitely don't need to. Thanks !
