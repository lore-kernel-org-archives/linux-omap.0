From: Vivek Kutal <vivek.kutal@celunite.com>
Subject: Re: [PATCH] Remove omap_sram_idle()
Date: Mon, 17 Dec 2007 11:54:24 +0530
Message-ID: <47661618.9030405@celunite.com>
References: <11977918242059-git-send-email-vivek.kutal@celunite.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742902CC143D@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742902CC143D@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Woodruff, Richard wrote:
>> 	This patch removes omap_sram_idle().
>>     
>
> Why?
>
>   
The function called in pm_idle is omap_sram_suspend, omap_sram_idle() is 
not used anywhere in omap1.
previously discussed here 
http://linux.omap.com/pipermail/linux-omap-open-source/2007-September/011422.html

--
Vivek Kutal
