From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the suspend
 is not implemented
Date: Tue, 24 Jan 2012 14:22:28 +0530
Message-ID: <4F1E714C.8090206@ti.com>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>	<1327306361-9803-3-git-send-email-shubhrajyoti@ti.com>
 <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Artem Bityutskiy <dedekind1@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 24 January 2012 01:39 PM, Brian Norris wrote:
> Hi,
>
> On Mon, Jan 23, 2012 at 12:12 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> ...
>>  include/linux/mtd/mtd.h |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
>> index 1a81fde..c717bb6 100644
>> --- a/include/linux/mtd/mtd.h
>> +++ b/include/linux/mtd/mtd.h
>> @@ -427,9 +427,9 @@ static inline int mtd_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>>
>>  static inline int mtd_suspend(struct mtd_info *mtd)
>>  {
>> -       if (!mtd->suspend)
>> -               return -EOPNOTSUPP;
>> -       return mtd->suspend(mtd);
>> +       if (mtd->suspend)
>> +               return mtd->suspend(mtd);
>> +       return 0;
>>  }
>>
>>  static inline void mtd_resume(struct mtd_info *mtd)
> I believe this fix is already accounted for in Artem Bityutskiy's
> l2-mtd-2.6 repository as:
>
> commit 091a7fe219ee8d3e76be9e02221433af10c6f574
> mtd: fix MTD suspend
> (http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/091a7fe219ee8d3e76be9e02221433af10c6f574)
>
> However, the bug made it into the 3.3 merge window, so shouldn't this
> bugfix be sent upstream immediately?
OK thanks for pointing that.
> Brian
