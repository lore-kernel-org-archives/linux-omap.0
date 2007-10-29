From: "Girish" <girishsg@ti.com>
Subject: RE: touch screen on 2430sdp not giving X and Y values
Date: Mon, 29 Oct 2007 12:52:39 +0530
Message-ID: <001701c819fc$7d6dcce0$6a8918ac@ent.ti.com>
References: <c656a4d20710282330x74dc71e0x68ca6c5309c3b643@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c656a4d20710282330x74dc71e0x68ca6c5309c3b643@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'arun c' <arun.edarath@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org



>But how can i check the Touch Screen interface power???  you 
>mean hardware wise checking??

I guess vaux2 has to be enabled for TS to work on 2430sdp, you can 
Cross check in TRM.
>>
>> >I downloaded the evtest.c from net to test the touch screen.
>> Try enabling debug statements in the driver(if exists or you can put 
>> some debug statements for printing x y & z).
>I will put debug messages and let you know.
>
>regards
>arun
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
