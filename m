From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Can DSP Gateway be used with OMAP 730
Date: Tue, 3 Apr 2007 14:20:41 +0530
Message-ID: <5d5443650704030150y508df10ej58a4f35ba811f86f@mail.gmail.com>
References: <61445c750704012346r17b0e84r8e160994e390af05@mail.gmail.com>
	<61445c750704020134g738c9550j365621d2c3ddf0e5@mail.gmail.com>
	<20070402.152956.88622893.Hiroshi.DOYU@nokia.com>
	<61445c750704030001w222840d4hfc75f4e8eac151b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <61445c750704030001w222840d4hfc75f4e8eac151b2@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: linux-omap-open-source@linux.omap.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

Hi Pharaoh,

On 4/3/07, Pharaoh . <pharaoh137@gmail.com> wrote:

>
>  Okay, now it is clear. DSP Gateway can not be used for OMAP 730. Since
>  the arch is different and OMAP 9 doesn't directly communicate with the
>  DSP, rather it communicates with ARM 7. So it is a different thing
>  altogether. The communication mechanism and and protocol more or less
>  is same i.e. using mailbox IPIs and shared memory.
>

Yes, DSPGW can't be used as is unless you have ARM9/11 and DSPC55x
combination as in case of OMAP1/OMAP2 series (except OMAP730 I
believe). But as you said it has ARM7 on the other side having
interface like mailbox and shared memory to talk with ARM9. In this
case you can develop similar interface like in current DSPGW (and most
of the code can be re-used). Think of IVA1.0 in OMAP2420. It is ARM7
with bunch of co-processor having their own SRAM's.

-- 
--Trilok Soni
