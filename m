From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: patch for kernel 2.6.12
Date: Wed, 22 Mar 2006 16:19:25 +0100
Message-ID: <44216AFD.9050406@gmail.com>
References: <7e6cc7550603220401i7277db4co6ad1535e856a2191@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7e6cc7550603220401i7277db4co6ad1535e856a2191@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: naga rajan <nagubk82@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

naga rajan wrote:
>  Hi all,
> 
>   I like to port linux kernel 2.6.12 in OMAP 5912 starter kit.I downloaded
> the associate patches from muru.com.I could not find any of the patches
> supporting *"OMAP5912 board"* in its *"SYSTEM TYPE"* ,kernel configuration
> option.I like to know the exact patch that supports OMAP5912 board or an
> equivalent solution(system configuration equivalent of OMAP5912).Please
> provide a solution

Try

System type -> TI OMAP Implementations -> OMAP System Type 
-> OMAP1

Then you should be able to select 'OMAP16xx Based System' 
and 'TI OSK Support' in system type. Or better use 'make 
omap_osk_5912_defconfig'. And much better use 2.6.16.

Dirk
