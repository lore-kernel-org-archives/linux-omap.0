From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: [PATCH] OMAP: Update n800_defconfig
Date: Wed, 28 Nov 2007 16:20:14 -0400
Message-ID: <474DCD7E.8020608@indt.org.br>
References: <1195778318-12008-1-git-send-email-lauri.leukkunen@nokia.com>	<1195778318-12008-2-git-send-email-lauri.leukkunen@nokia.com>	<1195778318-12008-3-git-send-email-lauri.leukkunen@nokia.com>	<1195778318-12008-4-git-send-email-lauri.leukkunen@nokia.com>
	<20071128021600.GD11825@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071128021600.GD11825@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Tony Lindgren wrote:
> * Lauri Leukkunen <lauri.leukkunen@nokia.com> [071122 16:38]:
>   
>> Enable N810 and lzo support for jffs2.
>>
>>     
>
> Pushing today, I've refreshed it to apply after Carlos' MMC patches.
>
> Tony
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>   
Hi Tony,

The n800_defconfig update proposed by Lauri Leukkunen' patch [1] is reverting my committed patch [2], that enables MMC support on n800_defconfig.

Should I resent my patch?

BR,

Carlos.

[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=d202198c6c1f78a92bae3d2e10dd6f76d19e02aa
[2] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=59c7c958830efe76e561dba8f20a9b4d5af3adfe


-- 
Carlos Eduardo Aguiar
Nokia Institute of Technology - INdT
Open Source Mobile Research Center - OSMRC - Manaus
Core Team
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br
