From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 0/3] MMC: OMAP: Adds MMC support for Siemens SX1 mobile
 phones
Date: Tue, 20 Nov 2007 10:14:50 -0400
Message-ID: <4742EBDA.9010507@indt.org.br>
References: <4717A601.1010702@indt.org.br> <4741EE83.80904@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4741EE83.80904@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org, omap-linux <linux-omap-open-source@linux.omap.com>, Vladimir Ananiev <vovan888@gmail.com>
List-Id: linux-omap@vger.kernel.org

ext Dirk Behme wrote:
> Carlos Aguiar wrote:
>> Hi Tony and folks,
>>
>> This patch series adds MMC support for Siemens SX1 mobile phone using
>> the new MMC multislot support code proposed in [1].
>>
>> I would like to thanks a lot to Vladimir Ananiev for testing the series.
>>
>> Testing and comments are welcome.
>>
>> BR,
>>
>> Carlos.
>>
>> [1]
>> http://linux.omap.com/pipermail/linux-omap-open-source/2007-September/011442.html
>>
>
Hi Dirk,
> Can you please check if this series is up to date? Trying to apply it
> results in rejects in arch/arm/mach-omap1/board-sx1.c of Patch 2/3.
The series is out to date. In fact, I have a version up to date. But,
after recent merging of linux-omap tree with linus tree, the multislot
support unexpectedly broken for N800 boards. H3 boards are working fine.
> Maybe you like to resend it?
As soon I solve this problem with N800, I'll resend the whole series.

BR,

Carlos.
>
> Many thanks
>
> Dirk
>
>


-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
