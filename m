From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] input: ads7846: can't disable filtering [was OMAP5912
 touchscreen irq not working]
Date: Mon, 05 Jun 2006 14:45:52 +0200
Message-ID: <44842780.3010507@gmail.com>
References: <4477F2BA.3080907@gmail.com> <44793CF9.2050101@nokia.com>	
	<447DB9CC.2070808@gmail.com>
	<200605310905.31864.david-b@pacbell.net>
	<1149093991.31999.66.camel@mammoth.research.nokia.com>
	<4481D7DE.2090904@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4481D7DE.2090904@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Imre Deak wrote:
> [ Didn't try on OSK, but seems to be the problem you had there. ]
> 
> When filtering is disabled the driver will ignore all samples and
> never detect the pen up event.

ts_calibrate now works on OSK, but, uhmm, not very good. 
Because the reaction of the cursor cross is so slow I first 
touched it several times until it moved to the next 
position. Then I noticed that it can take 1-2s after touch 
until it moves.

Using ts_test, the cursor cross is jumping wild if screen is 
touched, but not usable. I wasn't able to switch from Drag 
to Draw mode because I couldn't hit Draw.

Sorry, but at least on OSK with Mistral this new stuff isn't 
usable. Old driver worked quite well.

Regards

Dirk
