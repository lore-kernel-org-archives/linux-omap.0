From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: ISP1301 workqueue fixes
Date: Thu, 28 Dec 2006 17:19:37 +0100
Message-ID: <4593EE99.9080108@gmail.com>
References: <45937A00.1070803@gmail.com>
	<3a5b1be00612280430u5117383eme98f2d1ce50c411f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3a5b1be00612280430u5117383eme98f2d1ce50c411f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Komal Shah wrote:
> On 12/28/06, Dirk Behme <dirk.behme@googlemail.com> wrote:
...
>> Index: linux-osk/drivers/i2c/chips/isp1301_omap.c
>> ===================================================================
>> --- linux-osk.orig/drivers/i2c/chips/isp1301_omap.c
>> +++ linux-osk/drivers/i2c/chips/isp1301_omap.c
>> @@ -1119,9 +1119,9 @@ static u8 isp1301_clear_latch(struct isp
>>  }
>>
>>  static void
>> -isp1301_work(void *data)
>> +isp1301_work(struct work_struct *data)
>>  {
>> -       struct isp1301  *isp = data;
>> +       struct isp1301  *isp = (struct isp1301 *)data;
> 
> 
> Why not use container_of ? Did you tested it?

Can anybody with H2/H3 board test this? Same with board-h3 
workqueue fix from Ragner.

Many thanks

Dirk
