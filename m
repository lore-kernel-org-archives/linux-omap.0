From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/4] omap: mailbox: convert rwlocks to spinlock
Date: Mon, 10 May 2010 13:40:14 +0300 (EEST)
Message-ID: <20100510.134014.226801230.Hiroshi.DOYU@nokia.com>
References: <1273483013-5942-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<x2p94a0d4531005100312ocd30641ds7648e9a497e3dfd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <x2p94a0d4531005100312ocd30641ds7648e9a497e3dfd9@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: felipe.contreras@gmail.com
Cc: ohad@wizery.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] omap: mailbox: convert rwlocks to spinlock
Date: Mon, 10 May 2010 12:12:52 +0200

> On Mon, May 10, 2010 at 12:16 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
>> From: Ohad Ben-Cohen <ohad@wizery.com>
>>
>> rwlocks are slower and have potential starvation issues
>> therefore spinlocks are generally preferred.
>>
>> see also: http://lwn.net/Articles/364583/
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> Signed-off-by: Kanigeri Hari <h-kanigeri2@ti.com>
>> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> There's no cover letter, so I'll comment here.
> 
> What about these patches?
> http://article.gmane.org/gmane.linux.ports.arm.omap/31208

OK, I'll incorporate them and send patches again.

> 
> They are needed for dspbridge... AFAIK the only real user for omap mailbox.
> 
> -- 
> Felipe Contreras
