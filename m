From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Noise causes gpio interrupt
Date: Fri, 26 Jan 2007 15:15:22 +0100
Message-ID: <45BA0CFA.5010409@googlemail.com>
References: <740992.7549.qm@web55304.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <740992.7549.qm@web55304.mail.re4.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Arnold <abo_gwapo@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Arnold wrote:
> ... However when the interupt comes from a
> device and the transition of rise to fall is 20ns it
> could not detect that an interrupt occured. I also
> tried to increase the transition to 20ms and it was
> able to detect the interrupt. ...

Maybe http://www.ti.com/litv/pdf/spru767a, section 1.6 or 
page 28, can help:

"Because of the sample operation with the functional clock, 
the minimum pulse
width on the input GPIO to trigger a synchronous interrupt 
request is two times
the functional clock period. This minimum pulse width must 
be met before and
after any expected level transition detection."

Best regards

Dirk
