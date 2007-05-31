From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2: TWL4030 RTC driver
Date: Thu, 31 May 2007 14:05:44 +0400
Message-ID: <465E9DF8.6080806@gmail.com>
References: <20070531070651.5677.82640.stgit@T60>
	<5d5443650705310032m435b4bdcsf9a8efdb9433672f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650705310032m435b4bdcsf9a8efdb9433672f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Trilok,


thanks for the review.

Trilok Soni wrote:
>>
>> +config RTC_DRV_OMAP2430_TWL4030
>> +       tristate "OMAP243X TWL4030 Real Time Clock"
>> +       depends on RTC_CLASS && TWL4030_CORE
>> +       help
>> +         Support for TWL4030 companion chip internal RTC on OMAP2
>> SDP2430 board
>> +
>
> This driver should work on other boards having TWL4030 chip, so make
> help text more generic please. It is better if you don't have OMAP2430
> in RTC_DRV_OMAP2430_TWL4030

Agreed. We should avoid sticking to a particular board in general.
This issue, as well as codestyle issues you found, will be fixed.


Regards,
Dmitry
