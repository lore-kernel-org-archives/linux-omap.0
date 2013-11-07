From: Gururaja Hebbar <gururaja.hebbar@ti.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 7 Nov 2013 19:00:11 +0530
Message-ID: <527B95E3.9060802@ti.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
 <CANacCWz_ahKaACbAHuue1XwaN3gutBA7Z6W+=zWBn8LvLwDM5w@mail.gmail.com>
 <527A7E20.4040107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <527A7E20.4040107@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: joelf@ti.com, Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, balajitk@ti.com, s.neumann@raumfeld.com, Sekhar Nori <nsekhar@ti.com>, Daniel Mack <zonque@gmail.com>, Russ Dill <Russ.Dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Matt Porter <matt@ohporter.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 06 November 2013 11:06 PM, Joel Fernandes wrote:
> Hi Vaibhav,
> 
> On 10/31/2013 05:25 PM, Vaibhav Bedia wrote:
>> Hi Daniel,
>>
>> On Wed, Oct 30, 2013 at 4:21 PM, Daniel Mack <zonque@gmail.com> wrote:
>> [...]
>>> +
>>> +static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);
>>> +
>>>  static struct platform_driver edma_driver = {
>>>         .driver = {
>>>                 .name   = "edma",
>>> +               .pm     = &edma_pm_ops,
>>>                 .of_match_table = edma_of_ids,
>>>         },
>>
>> A while back we discovered a nasty race condition here that had us move the EDMA
>> PM callbacks to the noirq phase. IIRC the MMC driver was resuming
>> before the EDMA
>> driver had a chance to run and that was leading to a deadlock. I am
>> not sure how to force
>> this scenario but i do remember spending time debugging this on a
>> random codebase.
>> Maybe some else has some better ideas on how to force this race condition...
> 
> I think you're talking about the patch at [1] which is not upstream. A quick
> question with my limited knowledge of suspend/resume- How can there be pending
> I/O operations between suspend/resume cycles? 

AFAIK, MMC framework started talking to cards immediately after resume.
Due to race condition, EDMA resume callback had not yet completed and
HSMMC driver had initiated a DMA operation. This resulted in Deadlock.

regards
Gururaja

> The sync is done before suspend,
> so I don't understand how one is receiving a response from the card after resume
> before EDMA can resume? I'd imagine that until all devices are resumed, there
> will be no I/O operation issued. Let me know your thoughts.
> 
> thanks,
> 
> -Joel
> 
> [1]
> https://www.gitorious.org/x0148406-public/linux-kernel/commit/b81bf04091986fa3893f31955564594567be3b61
> 
