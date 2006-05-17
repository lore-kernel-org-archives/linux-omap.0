From: "Lucas Hartmann" <lucas.hartmann@gmail.com>
Subject: Re: Writeable Replacement for /dev
Date: Wed, 17 May 2006 10:09:28 -0300
Message-ID: <2a3728820605170609s7b14fe7eqbf875f6efafd4bda@mail.gmail.com>
References: <20060517033637.070E5CA0A6@ws5-11.us4.outblaze.com>
	<200605162045.37391.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605162045.37391.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Problem solved. Using devfs for now... I'm having a look at udev also.

Hanging was not for the lack of /dev, really. But is solved also.

--=20
Lucas Vinicius Hartmann
(83) 9967-4628

"As amizades duram enquanto cada amigo se acha ligeiramente superior ao
outro."
