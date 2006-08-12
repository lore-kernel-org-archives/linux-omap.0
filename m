From: Komal Shah <komal_shah802003@yahoo.com>
Subject: RE: status of OMAP ALSA support
Date: Sat, 12 Aug 2006 02:51:50 -0700 (PDT)
Message-ID: <20060812095150.72775.qmail@web37914.mail.mud.yahoo.com>
References: <304D2A85A9643F4A991BDDF8D297BBA6040F63E8@dlee05.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <304D2A85A9643F4A991BDDF8D297BBA6040F63E8@dlee05.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Zhang, Jian" <jzhang@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- "Zhang, Jian" <jzhang@ti.com> wrote:

> Mika,
> 
> Thanks for the response. I have overlooked this email until today.
> 
> Good to know it is tested on H2. I should be able to get a H2. I
> tried
> to build a H3 kernel with tsc2101 codec. The alsa core reported no
> sound
> card. It seems that snd_card_new() fails silently in omap alsa core. 
> 
> I don't have any fixes yet. I can add H3/H4 support once I first have
> it
> run on H2 (I am new to sound so need some tracing of control flow:))
> The
> current focus is to understand ALSA. I have asked you a dummy
> configuration question in a separate email. Any help from you is
> appreciated.   

And to make it work on H4, it is better to have tsc2101 protocol driver
understanding the current OMAP2-spi driver _or_ better if Juha releases
tsc2301 driver early, so that we can derive tsc2101 changes straight
from there ;) 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
