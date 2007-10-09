From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH 0/14] MMC: OMAP: Add MMC multislot support
Date: Tue, 09 Oct 2007 14:12:08 -0400
Message-ID: <470BC478.3050505@indt.org.br>
References: <46F28BA0.3080002@indt.org.br> <20071009153436.GD7784@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20071009153436.GD7784@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

ext Tony Lindgren wrote:
> * Carlos Aguiar <carlos.aguiar@indt.org.br> [070920 08:04]:
>   
>> Hi Tony and folks,
>>
>> This is the latest 'MMC: OMAP: Add MMC multislot support' patch series
>> with changes, corrections and improvements based on comments and
>> suggestions from community (mainly Tony, Brownell and Trilok) and coworkers.
>>
>> Just to remind you, this patch series adds the MMC multislot support for
>> N800 and TI OMAP H2 and H3 boards. It's based on Juha's and Jarkko's
>> earlier implementation and it can be applied against most updated
>> linux-omap tree (2.6.23-rc6-omap1).
>>
>> I've tested with MMC, SD and SDHC cards and looks fine for the boards
>> mentioned above.
>>
>> Testing, comments and suggestions are welcome.
>>     
>
>   
Hi Tony,
> Any news on using these patches on 1510? There are several 15xx based
> boards where the only root is MMC, so we should make sure it works on
> 15xx before applying these.
>   
I'm working now with an Innovator 1510 in order to provide such support
to this board.

I've already implemented a version for Siemens SX1 (1510 based). Today
I'll send to Vladimir Ananiev and Pavel Machek (as I remember, they
provided the MMC support on linux-omap tree) to test it. I have no such
boards here.

As soon as the support is working on 1510 I'll send the patches to you
and Linux-OMAP mailing list.

BR,

Carlos.
> Regards,
>
> Tony
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
