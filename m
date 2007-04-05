From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: OMAP2430 NAND Boot
Date: Thu, 05 Apr 2007 06:16:59 -0500
Message-ID: <4614DAAB.4090405@gmail.com>
References: <42E999AD7A0E4647BF159F467EE4FBCB014B1391@BLR-SGM-MSG01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <42E999AD7A0E4647BF159F467EE4FBCB014B1391@BLR-SGM-MSG01.wipro.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sathish.madhava@wipro.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

sathish.madhava@wipro.com stated on 4/4/2007 10:55 PM:
> 1. What kind of tool is to be used to convert x-load.raw into
> x-load.raw.ift ?
>   
CSST can help here..
> 2. Where can I get this tool ?
>   
http://focus.ti.com/general/docs/wtbu/wtbugencontent.tsp?contentId=14645&navigationId=12013&templateId=6123
> 3. Or is it just editing some data in x-load.raw file or something else
> ?
>   
no.. it is a matter of signint it.. read thru the quick start guide..
also the release notes.
> I have used u-boot to burn itself back into NAND flash and now trying to
> program Xloader with CSST.
>   
:) U knew it :).... u can actually do flashing of all using csst.. not
just signing.. in fact there are stuff in the csst tool that will allow
u to do board diagnostics also..
Regards,
Nishanth Menon
