From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] Convert touchscreen to input_allocate_device
Date: Wed, 18 Jan 2006 13:21:55 +0200
Message-ID: <20060118112155.GA16067@two.research.nokia.com>
References: <890E52023811004CB455C1B7C433BA101A8B29@dino.eu.tieto.com>
	<20060118101057.83839.qmail@web32903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060118101057.83839.qmail@web32903.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com, Mikko.Soikkala@tietoenator.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 18, 2006 at 02:10:57AM -0800, ext Komal Shah wrote:

> > How about if we move the allocation and check to the beginning of the
> > probe function? Then the return shouldn't cause problems?
> 
> Ok. Looks good now.

Not quite yet. =) If you allocate the input device earlier, you also have to
take care in deallocating it in the error paths after it.

Cheers,
Juha
